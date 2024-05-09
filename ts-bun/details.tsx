const data = [
  ['Bun', 'https://bun.sh/docs', 'https://bun.sh/logo_avatar.svg'],
  ['HTMX', 'https://htmx.org/docs', 'https://htmx.org/img/htmx_logo.2.png'],
  ['Hono', 'https://hono.dev/', 'https://hono.dev/images/logo.png'],
];


export default () => {
  return (
    <>
      <h3 style="text-align:center;">Welcome to HTMX!</h3>
      <p>You're using these tools, check their docs to learn more:</p>
      <ul>
        {data.map(([name, url, img]) => (
          <li>
            <img src={img} />
            <a href={url}>{name}</a>
          </li>
        ))}
      </ul>
    </>
  );
};