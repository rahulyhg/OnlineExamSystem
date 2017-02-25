package util.googleapi.exception;

/**
 *
 * @author nguyen
 */
public class TokenExchangeException extends Exception {

    private static final String EXCEPTION_MESSAGE = "Could not exchange authorization code for an access token.";

    public TokenExchangeException() {
        super(EXCEPTION_MESSAGE);
    }

    public TokenExchangeException(Throwable cause) {
        super(EXCEPTION_MESSAGE, cause);
    }

}
