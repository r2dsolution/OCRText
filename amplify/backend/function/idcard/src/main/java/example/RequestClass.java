

package example;
        
     public class RequestClass {
        String firstName;
        String lastName;
        String body;

        public String getFirstName() {
            return firstName;
        }

        public void setFirstName(String firstName) {
            this.firstName = firstName;
        }

        public String getLastName() {
            return lastName;
        }

        public void setLastName(String lastName) {
            this.lastName = lastName;
        }
        
        public String getBody() {
            return body;
        }

        public void setBody(String body) {
            this.body = body;
        }

        public RequestClass(String firstName, String lastName) {
            this.firstName = firstName;
            this.lastName = lastName;
            this.body = body;
        }

        public RequestClass() {
        }
    }