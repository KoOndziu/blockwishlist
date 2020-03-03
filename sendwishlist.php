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

require_once(dirname(__FILE__).'/../../config/config.inc.php');
require_once(dirname(__FILE__).'/../../init.php');
require_once(dirname(__FILE__).'/WishList.php');
require_once(dirname(__FILE__).'/blockwishlist.php');

$context = Context::getContext();

// Instance of module class for translations
$module = new BlockWishList();

if (Configuration::get('PS_TOKEN_ENABLE') == 1 and
    strcmp(Tools::getToken(false), Tools::getValue('token')) and
    $context->customer->isLogged() === true) {
    exit($module->l('invalid token', 'sendwishlist'));
}

if ($context->customer->isLogged()) {
    $id_wishlist = (int) Tools::getValue('id_wishlist');
    if (empty($id_wishlist) === true) {
        exit($module->l('Invalid wishlist', 'sendwishlist'));
    }
    for ($i = 1; empty(Tools::getValue('email')) === false; ++$i) {
        $to = Tools::getValue('email'.$i);
        $wishlist = WishList::exists($id_wishlist, $context->customer->id, true);
        if ($wishlist === false) {
            exit($module->l('Invalid wishlist', 'sendwishlist'));
        }
        if (WishList::addEmail($id_wishlist, $to) === false) {
            exit($module->l('Wishlist send error', 'sendwishlist'));
        }
        $toName = (string) Configuration::get('PS_SHOP_NAME');
        $customer = $context->customer;
        if (Validate::isLoadedObject($customer)) {
            Mail::Send(
                $context->language->id, 'wishlist',
                sprintf(
                    Mail::l('Message from %1$s %2$s', $context->language->id),
                    $customer->lastname,
                    $customer->firstname
                ),
                [
                    '{lastname}'  => $customer->lastname,
                    '{firstname}' => $customer->firstname,
                    '{wishlist}'  => $wishlist['name'],
                    '{message}'   => $context->link->getModuleLink('blockwishlist', 'view', ['token' => $wishlist['token']])
                ],
                $to,
                $toName,
                $customer->email,
                $customer->firstname.' '.$customer->lastname,
                null,
                null,
                dirname(__FILE__).'/mails/'
            );
        }
    }
}
