<?php
/**
 * 2015-2020 Ko_Ondziu
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to http://www.prestashop.com for more information.
 *
 * @author    Ko_Ondziu <000konrad000@gmail.com>
 * @copyright 2015-2020 Ko_Ondziu
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 */
/* SSL Management */
$useSSL = true;

require_once(dirname(__FILE__).'/../../config/config.inc.php');
require_once(dirname(__FILE__).'/../../init.php');
require_once(dirname(__FILE__).'/WishList.php');
require_once(dirname(__FILE__).'/blockwishlist.php');

$error = '';
$context = Context::getContext();
if (is_null($context->cart->id)) {
    $context->cart->add();
    $context->cookie->__set('id_cart', $context->cart->id);
}

// Instance of module class for translations
$module = new BlockWishList();
$token = Tools::getValue('token');
$id_product = (int) Tools::getValue('id_product');
$id_product_attribute = (int) Tools::getValue('id_product_attribute');

if (Configuration::get('PS_TOKEN_ENABLE') == 1 && strcmp(Tools::getToken(false), Tools::getValue('static_token'))) {
    $error = $module->l('Invalid token', 'buywishlistproduct');
}

if (!Tools::strlen($error) &&
    empty($token) === false &&
    empty($id_product) === false) {
    $wishlist = WishList::getByToken($token);
    if ($wishlist !== false) {
        WishList::addBoughtProduct($wishlist['id_wishlist'], $id_product, $id_product_attribute, $context->cart->id, 1);
    }
} else {
    $error = $module->l('You must log in', 'buywishlistproduct');
}

if (empty($error) === false) {
    echo $error;
}
