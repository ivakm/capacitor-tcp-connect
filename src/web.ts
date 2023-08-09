import { WebPlugin } from '@capacitor/core';

import type { SocketConnectPlugin } from './definitions';

export class SocketConnectWeb extends WebPlugin implements SocketConnectPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
