

package example;

import com.amazonaws.services.lambda.runtime.Context; 
import com.amazonaws.services.lambda.runtime.RequestHandler;

public class LambdaRequestHandler implements RequestHandler<RequestClass, ResponseClass>{   

    public ResponseClass handleRequest(RequestClass request, Context context){
        String greeting = String.format("Hello %s", request.body);
        String firstname = "name";
        String lastname = "lastname";
        String idCardNo = "123456789";
        // ResponseClass response =  new ResponseClass();
        // response.setFirstname(firstname);
        // response.setLastname(lastname);
        // response.setIdCardNo(idCardNo);
        // response.setGreetings(greeting);

        ResponseClass response =  new ResponseClass(greeting,firstname,lastname,idCardNo);
        return response;
        
    }
}