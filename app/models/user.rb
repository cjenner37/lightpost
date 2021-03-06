class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

   has_many :workout_creations, class_name: "Workout"
   has_many :subscriptions, dependent: :destroy
   has_many :workouts, through: :subscriptions
   has_many :posts, dependent: :destroy
   has_many :comments, dependent: :destroy

   validates :first_name, presence: true

   has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
   validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

   def full_name
     first_name + " " + last_name
   end
end
 