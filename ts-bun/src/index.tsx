import { serveStatic } from 'hono/bun';
import { Hono } from 'hono';

import Details from './details.tsx';

const PORT = process.env.PORT || 3000;
const app = new Hono();

app.use('/assets/*', serveStatic({ root: './' }));
app.get('/', (c) => c.html(Bun.file('index.html')));
app.get('/details', (c) => {
  return c.html(<Details />)
});

console.log(`\x1b[32m${Math.random() * 10e5 | 0} | Server is running on ${PORT}\x1b[0m`);
export default {
  port: PORT,
  fetch: app.fetch,
}