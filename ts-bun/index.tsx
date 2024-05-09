import { serveStatic } from 'hono/bun';
import { Hono } from 'hono';

import Details from './details.js';

const PORT = process.env.PORT || 3000;
const app = new Hono();

app.use('/assets/*', serveStatic({ root: './' }));
app.get('/', (c) => c.html(Bun.file('index.html').text()));
app.get('/details', (c) => {
  return c.html(<Details />)
});

console.log(`Server is running on ${PORT}`);

export default {
  port: PORT,
  fetch: app.fetch,
}