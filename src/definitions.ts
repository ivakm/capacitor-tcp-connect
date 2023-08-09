export interface SocketConnectPlugin {
  open(options: {
    ip: string;
    port: string;
    text: string;
  }): Promise<{ value: string }>;
}