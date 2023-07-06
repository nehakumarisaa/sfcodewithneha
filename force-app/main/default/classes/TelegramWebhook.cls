@RestResource(urlMapping = '/telegramWebhook')
global class TelegramWebhook {
    @HttpPost
    global static void doPost() {
        system.debug('**Inside Class**');
        Map<String, Object> dataReceived = (Map<String, Object>) JSON.deserializeUntyped (RestContext.request.requestBody.toString());
        //Get user and message details
        Map<String, Object> message = (Map<String, Object>) dataReceived.get( 'message');
        Map<String, Object> chat = (Map<String, Object>) message.get('chat');
        Map<String, Object> fromUser = (Map<String, Object>) message.get('from');
        //Get user( Sender) Id
        Integer userId = Integer.valueof(fromUser.get('id'));
        String reply = '';
        //Find contact
        List<Contact> contacts = [SELECT id FROM Contact WHERE Telegram_user_ID__C = : userId];
        //If contact not found, create new contact                         
        if(contacts.size() == 0) {
            String firstName = String.valueOf(fromUser.get('first_name'));
            String lastname = String.valueof(fromUser.get('last_name'));
            Contact contact = new Contact(FirstName = firstName, LastName = lastname, Telegram_user_ID__C = userId);
            insert contact;
            reply = 'Contact Created! You can now receive updates from Salesforce.\nThanks';
        } else {
            reply = 'You can receive updates from Salesforce.\nThanks';
        }
        //Send reply
        sendMessage(userId, reply);
    }
    @future(callout = true)
    private static void sendMessage(Integer userid, String reply) {
        TelegramUtility.Message message = new TelegramUtility.Message(userId, reply);
        TelegramUtility.sendMessage( message);
    }
}