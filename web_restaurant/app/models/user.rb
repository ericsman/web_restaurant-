class User < ApplicationRecord
    has_secure_password
    has_secure_token :confirmation_token
    
    validates :username, 
    format: {with: /\A[a-zA-Z0-9_]{2,20}\z/, message: 'remplire avec des caractéres alphanumeriques et des underscore'},
    uniqueness: {case_sensitive: false}
    validates :email, 
    format: {with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/, message: 'remplissez le section SVP'},
    uniqueness: {case_sensitive: false}

    def to_session
        {id: id }
    end

end
