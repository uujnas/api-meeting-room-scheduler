class MemberMailer < ApplicationMailer
  default from: 'shresthabikash2073@gmail.com'

  def members_added_on_meeting(member, meeting)
    @member = member
    @meeting = meeting
    @url = 'https://bajratechnoogies.com'
    mail(to: @member, subject: "You have been added to #{@meeting.subject}")
  end
end
