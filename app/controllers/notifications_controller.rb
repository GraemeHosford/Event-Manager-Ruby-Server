class NotificationsController < ApplicationController
  require "google/cloud/firestore"
  require "json"
  require "net/http"
  
  def create
    firestore = Google::Cloud::Firestore.new(project_id: ENV['FIRESTORE_PROJECT'], credentials: ENV['GOOGLE_APPLICATION_CREDENTIALS'])

    emails = Array[params[:emails]]

    emails.each do |e|
      user = firestore.col('users').doc(e).get
      
      messaging_token = user.get('messaging_token')
      
      if token != null
        post_url = URI.parse("https://fcm.googleapis.com/fcm/send")
        request = Net::HTTP::Post.new(post_url)
        
        notification_title = "You have been invited to a new event!"
        notification_body = "Tap here to see your invites"
        
        request_body = {"data": {"title": notification_title, "body": notification_body}, "to": messaging_token}.to_json
        
        request.content_type = 'application/json'
        request['authorization'] = ENV['FCM_KEY']
        
        result = Net::HTTP.start(post_url.host, post_url.port, :use_ssl => true) do |http|
          http.request(request)
        end
      end
    end
  end
end
