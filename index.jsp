import com.sun.net.httpserver.HttpServer;
import com.sun.net.httpserver.HttpHandler;
import com.sun.net.httpserver.HttpExchange;

import java.io.OutputStream;
import java.net.InetSocketAddress;

public class SimpleWebsite {

    public static void main(String[] args) throws Exception {
        HttpServer server = HttpServer.create(new InetSocketAddress(8080), 0);
        server.createContext("/", new MyHandler());
        server.setExecutor(null); // default executor
        server.start();

        System.out.println("Server started at http://localhost:8080");
    }

    static class MyHandler implements HttpHandler {
        @Override
        public void handle(HttpExchange exchange) {
            try {
                String htmlResponse =
                        "<!DOCTYPE html>" +
                        "<html>" +
                        "<head>" +
                        "<title>Pure Java Website</title>" +
                        "<style>" +
                        "body { font-family: Arial; background: #f4f4f4; text-align: center; }" +
                        "h1 { color: #333; }" +
                        "</style>" +
                        "</head>" +
                        "<body>" +
                        "<h1>Welcome to My Java Website</h1>" +
                        "<p>This website is made using pure Java!</p>" +
                        "</body>" +
                        "</html>";

                exchange.sendResponseHeaders(200, htmlResponse.length());
                OutputStream os = exchange.getResponseBody();
                os.write(htmlResponse.getBytes());
                os.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}

