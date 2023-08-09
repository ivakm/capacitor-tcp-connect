package com.mycompany.plugins.example;

import com.getcapacitor.JSObject;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.annotation.CapacitorPlugin;
import com.getcapacitor.PluginMethod;

import java.io.OutputStream;
import java.net.Socket;

@CapacitorPlugin(name = "SocketConnect")
public class SocketConnectPlugin extends Plugin {

    @PluginMethod()
    public void open(PluginCall call) {
        String ip = call.getString("ip");
        String port = call.getString("port");
        String text = call.getString("text");

        try {
            Socket socket = new Socket(ip, Integer.parseInt(port));
            OutputStream outputStream = socket.getOutputStream();
            outputStream.write(text.getBytes());
            outputStream.close();
            socket.close();

            JSObject ret = new JSObject();
            ret.put("success", true);
            call.resolve(ret);
        } catch (Exception e) {
            call.reject(e.getMessage(), e);
        }
    }
}
