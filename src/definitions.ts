export interface SocketConnectPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
