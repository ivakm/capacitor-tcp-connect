import { registerPlugin } from '@capacitor/core';

import type { SocketConnectPlugin } from './definitions';

const SocketConnect = registerPlugin<SocketConnectPlugin>('SocketConnect');

export * from './definitions';
export { SocketConnect };
