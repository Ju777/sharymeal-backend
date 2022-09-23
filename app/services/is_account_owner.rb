class IsAccountOwner
    def is_owner?(requester_id)
        return requester_id === current_user.id ? true : false
    end
end