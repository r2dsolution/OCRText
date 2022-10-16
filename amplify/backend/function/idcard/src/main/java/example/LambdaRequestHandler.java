

package example;

import com.amazonaws.services.lambda.runtime.Context; 
import com.amazonaws.services.lambda.runtime.RequestHandler;

public class LambdaRequestHandler implements RequestHandler<RequestClass, ResponseClass>{   

    public ResponseClass handleRequest(RequestClass request, Context context){
        String greetingString = String.format("Hello %s", request.body);
        String nameString = String.format("Hello %s", request.body);
        String addressString = String.format("Hello %s", request.body);
        String idcardnumberString = String.format("Hello %s", request.body);
        return new ResponseClass(greetingString) ,(nameString) ,(addressString) ,(idcardnumberString);
        
    }
}