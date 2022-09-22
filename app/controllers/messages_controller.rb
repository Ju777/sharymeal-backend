class MessagesController < ApplicationController
  before_action :set_message, only: %i[ show update destroy ]

  # GET /messages
  def index
    @messages = Message.all.order(created_at: "desc")

    render json: @messages.as_json(include: [:sender, :recipient])
  end

  # GET /messages/1
  def show
    render json: @message
  end

  # GET /conversations/1
  def get_conversation
      user = get_user_from_token
      current_user_conversations = Message.all.where(sender: user, recipient: User.find(params[:id])).or(Message.all.where(sender: User.find(params[:id]), recipient: user)).order(:created_at)
      render json: {
      conversations: current_user_conversations
      }
  end

  # GET /last_message/1
  def get_last_message
        user = get_user_from_token
        last_message = Message.all.where(sender: user, recipient: User.find(params[:id])).or(Message.all.where(sender: User.find(params[:id]), recipient: user)).last
        render json: {
            last_message: last_message.as_json(only: [:content, :created_at]),
            user: UserSerializer.new(last_message.recipient === user ? last_message.sender : last_message.recipient).serializable_hash[:data][:attributes]
        }
  end




  # POST /messages
  def create
    @message = Message.new(message_params)

    if @message.save
      render json: @message, status: :created, location: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /messages/1
  def update
    if @message.update(message_params)
      render json: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # DELETE /messages/1
  def destroy
    @message.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

      def get_user_from_token
        jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1], ENV["JWT_SECRET_KEY"]).first
        user_id = jwt_payload['sub']
        User.find(user_id.to_s)
      end

    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:content, :recipient_id, :sender_id)
    end
end
