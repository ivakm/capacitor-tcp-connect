export interface SocketConnectPlugin {
  echo(options: {
    ip: string;
    port: string;
    text: string;
  }): Promise<{ value: string }>;
}