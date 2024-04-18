package db;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class AwsConnect {
    private Properties prop = new Properties();

    public AwsConnect() {
        try {
            InputStream input = DbConnect.class.getClassLoader().getResourceAsStream("db/db.properties");
            prop.load(input);

        } catch (FileNotFoundException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
    public String getAccessKey() {
        return prop.getProperty("aws.s3.accessKey").replace("\"", "");
    }

    public String getSecretKey() {
        return prop.getProperty("aws.s3.secretKey").replace("\"", "");
    }
}