public with sharing class TextErrorExtn {

    public TextErrorExtn(ApexPages.StandardController controller) {
      ApexPages.Message errorMsg = new ApexPages.Message(ApexPages.Severity.FATAL, ' Test Apex page message!');
      ApexPages.addMessage(errorMsg);
    }

}