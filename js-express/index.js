import { engine } from 'express-handlebars';
import express from 'express';

const PORT = 3000;
const app = express();
const router = express.Router();

app.use( "/assets", express.static( __dirname + "/assets" ) );
app.engine( 'hbs', engine( { extname: ".hbs", defaultLayout: false } ) );
app.set( 'view engine', 'hbs' );
app.set( 'views', './views' );

router
  .get( '/', ( req, res ) => {
    return res.sendFile( 'index.html', { root: __dirname } );
  } )
  .get( '/details', ( req, res ) => {
    return res.render( 'details', {
      data: [
        [ 'Express', 'https://expressjs.com', 'https://expressjs.com/images/favicon.png' ],
        [ 'HTMX', 'https://htmx.org/docs', 'https://htmx.org/img/htmx_logo.2.png' ],
        [ 'Handlebars', 'https://handlebarsjs.com', 'https://handlebarsjs.com/images/handlebars_logo.png'
        ]
      ]
    } );
  } );


app.use( '/', router );
app.listen( PORT, () => {
  console.log( 'Server at port ', PORT )
} );