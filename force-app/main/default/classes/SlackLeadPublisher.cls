public with sharing class SlackLeadPublisher {
     
    private static final String slackURL = 'https://hooks.slack.com/services/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';
     
    public class leads {
        @InvocableVariable(label='Lead Name')
        public String leadName;
        @InvocableVariable(label='Status')
        public String status;
        @InvocableVariable(label='Email')
        public String email;
    }
     
    @InvocableMethod(label='Post Lead to Slack')
    public static void postToSlack(List<leads> leadList) {
        leads l = leadList[0]; 
        Map<String,Object> msg = new Map<String,Object>();
        msg.put('text', 'The following lead has been created:\n' + l.leadName + '\nStatus: *' + l.status + '*' + '\nEmail: *' + l.email);
        msg.put('mrkdwn', true);
        String body = JSON.serialize(msg);    
        System.enqueueJob(new QueueableSlackCall(slackURL, 'POST', body));
    }
     
    public class QueueableSlackCall implements System.Queueable, Database.AllowsCallouts {
         
        private final String url;
        private final String method;
        private final String body;
         
        public QueueableSlackCall(String url, String method, String body) {
            this.url = url;
            this.method = method;
            this.body = body;
        }
         
        public void execute(System.QueueableContext ctx) {
            HttpRequest req = new HttpRequest();
            req.setEndpoint(url);
            req.setMethod(method);
            req.setBody(body);
            Http http = new Http();
            HttpResponse res = http.send(req);
            system.debug('**Res**'+res);
        }
 
    }
    
}