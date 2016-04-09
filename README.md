# Text-Sender
This is a little app that uses Twilio to send text messages.  It's more of a chance to exercise my skills than an attempt to provide any novel functionality.  But so far, it's given me a chance to:
 * play with Sinatra
 * do a bit of Bootstrap
 * use Twilio's API to send text messages (currently only to myself)
 * use Sidekiq (and Redis) to ensure that if thousands of people started using this app to send text messages to the only currently supported number (mine), that they would all go through eventually
 
## To Do
 * Think through how to improve the error-handling, now that Sidekiq delays the errors and hides them from the user
 * Hook this up to a database, which could serve as an address book, plus a record of sent texts
