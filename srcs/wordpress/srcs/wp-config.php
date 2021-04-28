<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** MySQL database username */
define( 'DB_USER', 'robitett' );

/** MySQL database password */
define( 'DB_PASSWORD', 'TPPxG9ydre' );

/** MySQL hostname */
define( 'DB_HOST', 'mysql' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         'OgDe`<D,u7uBK5C%a?|i::CJ/>:(s;WZ|SY#~ru!l ^1@Q?1oZ.!L+L!&9+wj7v7');
define('SECURE_AUTH_KEY',  '8kEK*1hw*zAt2}pz )WlLPP|K,[_]+ak{q6CKl>Kf^[:9Hpa n]f}~(3EA!1IlNN');
define('LOGGED_IN_KEY',    '-IoEofX_os7dB~BSHfWprp*]7) )[f[Gi)}&i-KCRtApG%xtc*h()9+oi-SC]QC$');
define('NONCE_KEY',        'WLh]+%^YRsF8pCO( ZfLs%qK;t)I/VF1BoWd.f9Qlu;m;?K/Rgm]+|oa(ah^A. 6');
define('AUTH_SALT',        'K-N*uWL,i#asJd!ow@]e#_:gX.2|t}NeQV_j{.Gys1N+u<1ITE,40g-~X^&gIeC@');
define('SECURE_AUTH_SALT', '~;|[xj,<@>bb=!nxw+o<!L4Oodzg0|%042BG$DeAU^/klsuA+LEQY4GNc3Mp[&E5');
define('LOGGED_IN_SALT',   'kv}|6x 9aZstA@/|65BB0l^wER{Bde-vWCe?-j94_#tfv*{asN4AtsVtx&Dh<6^|');
define('NONCE_SALT',       'k*$1qpou-$1eHbpkt)KyO$R(n-0c91cu[Y%)#;+UU-`A/^=W@6ot6Njq-+;L^)+s');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
