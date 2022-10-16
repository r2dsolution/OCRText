

package example;
        
     public class ResponseClass {
        String greetings;
        String firstname;
        String lastname;
        String idCardNo;

       

        public String getIdCardNo() {
            return idCardNo;
        }

        public void setIdCardNo(String idCardNo) {
            this.idCardNo = idCardNo;
        }

        public String getLastname() {
            return lastname;
        }

        public void setLastname(String lastname) {
            this.lastname = lastname;
        }

        public String getFirstname() {
            return firstname;
        }

        public void setFirstname(String firstname) {
            this.firstname = firstname;
        }

        public String getGreetings() {
            return this.greetings;
        }

        public void setGreetings(String greetings) {
            this.greetings = greetings;
        }

        public ResponseClass() {
            
        }
    
        public ResponseClass(String greetings, String firstname, String lastname, String idCardNo) {
            this.greetings = greetings;
            this.firstname = firstname;
            this.lastname = lastname;
            this.idCardNo = idCardNo;
        }
     
    }