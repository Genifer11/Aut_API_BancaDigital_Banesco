package utils;

import org.apache.commons.codec.binary.Base64;
import org.apache.oltu.oauth2.client.OAuthClient;
import org.apache.oltu.oauth2.client.URLConnectionClient;
import org.apache.oltu.oauth2.client.request.OAuthClientRequest;
import org.apache.oltu.oauth2.client.response.OAuthJSONAccessTokenResponse;
import org.apache.oltu.oauth2.common.OAuth;
import org.apache.oltu.oauth2.common.exception.OAuthProblemException;
import org.apache.oltu.oauth2.common.exception.OAuthSystemException;
import org.apache.oltu.oauth2.common.message.types.GrantType;

import java.nio.charset.StandardCharsets;

public class AccesToken {

        public static String getAccessToken() throws OAuthSystemException, OAuthProblemException {
            String clientID = "4135ven139je3pc4iplu7kpp48";
            String clientSecret = "aequ8699svva2gbuplrvae3l8jhm86gj1mh0cu7e9p54u7loafv";
            String tokenURL = "https://test-auth-ob.banesco.com.pa/oauth2/token";

            String encodedValue = getBase64Encoded(clientID, clientSecret);

            OAuthClient client = new OAuthClient(new URLConnectionClient());

            OAuthClientRequest request = OAuthClientRequest
                    .tokenLocation(tokenURL)
                    .setGrantType(GrantType.CLIENT_CREDENTIALS)
                    .buildBodyMessage();

            request.addHeader("Authorization", "Basic " + encodedValue);

            OAuthJSONAccessTokenResponse authResponse = client.accessToken(request, OAuth.HttpMethod.POST, OAuthJSONAccessTokenResponse.class);
            return authResponse.getAccessToken();
        }

        private static String getBase64Encoded(String id, String password) {
            return Base64.encodeBase64String((id + ":" + password).getBytes(StandardCharsets.UTF_8));
        }
    }