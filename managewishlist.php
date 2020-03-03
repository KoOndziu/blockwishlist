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
$context = Context::getContext();
if ($context->customer->isLogged()) {
    $action = Tools::getValue('action');
    $id_wishlist = (int) Tools::getValue('id_wishlist');
    $id_product = (int) Tools::getValue('id_product');
    $id_product_attribute = (int) Tools::getValue('id_product_attribute');
    $quantity = (int) Tools::getValue('quantity');
    $priority = Tools::getValue('priority');
    $wishlist = new WishList((int) ($id_wishlist));
    $refresh = ((Tools::getValue('refresh') == 'true') ? 1 : 0);
    if (empty($id_wishlist) === false) {
        if (!strcmp($action, 'update')) {
            WishList::updateProduct($id_wishlist, $id_product, $id_product_attribute, $priority, $quantity);
        } else {
            if (!strcmp($action, 'delete')) {
                WishList::removeProduct($id_wishlist, (int) $context->customer->id, $id_product, $id_product_attribute);
            }

            $products = WishList::getProductByIdCustomer($id_wishlist, $context->customer->id, $context->language->id);
            $bought = WishList::getBoughtProduct($id_wishlist);
            $link = new Link();

            for ($i = 0; $i < sizeof($products); ++$i) {
                $obj = new Product((int) ($products[$i]['id_product']), false, $context->language->id);
                if (!Validate::isLoadedObject($obj)) {
                    continue;
                } else {
                    if ($products[$i]['id_product_attribute'] != 0) {
                        $combination_imgs = $obj->getCombinationImages($context->language->id);
                        if (isset($combination_imgs[$products[$i]['id_product_attribute']][0])) {
                            $coverImg = $obj->id.'-'.$combination_imgs[$products[$i]['id_product_attribute']][0]['id_image'];
                            $products[$i]['image_link'] = $link->getImageLink($products[$i]['link_rewrite'], $coverImg, ImageType::getFormattedName('home'));
                        } else {
                            $cover = Product::getCover($obj->id);
                            $coverImg = $obj->id.'-'.$cover['id_image'];
                            $products[$i]['image_link'] = $link->getImageLink($products[$i]['link_rewrite'], $coverImg, ImageType::getFormattedName('home'));
                        }
                    } else {
                        $images = $obj->getImages($context->language->id);
                        foreach ($images as $k => $image) {
                            if ($image['cover']) {
                                $coverImg = $obj->id.'-'.$image['id_image'];
                                $products[$i]['image_link'] = $link->getImageLink($products[$i]['link_rewrite'], $coverImg, ImageType::getFormattedName('home'));
                                break;
                            }
                        }
                    }
                    if (!isset($products[$i]['image_link'])) {
                        $products[$i]['image_link'] = 'img/p/'.$context->language->iso_code.ImageType::getFormattedName('home');
                    }
                }
                $products[$i]['bought'] = false;
                for ($j = 0, $k = 0; $j < sizeof($bought); ++$j) {
                    if ($bought[$j]['id_product'] == $products[$i]['id_product'] and
                        $bought[$j]['id_product_attribute'] == $products[$i]['id_product_attribute']) {
                        $products[$i]['bought'][$k++] = $bought[$j];
                    }
                }
            }

            $productBoughts = array();

            foreach ($products as $product) {
                if ($product['bought']) {
                    $productBoughts[] = $product;
                }
            }
            $context->smarty->assign([
                'products'        => $products,
                'productsBoughts' => $productBoughts,
                'id_wishlist'     => $id_wishlist,
                'refresh'         => $refresh,
                'token_wish'      => $wishlist->token,
                'wishlists'       => WishList::getByIdCustomer($context->cookie->id_customer)
            ]);

            // Instance of module class for translations
            $module = new BlockWishList();

            if (Tools::file_exists_cache(_PS_THEME_DIR_.'modules/blockwishlist/views/templates/front/managewishlist.tpl')) {
                $context->smarty->display(_PS_THEME_DIR_.'modules/blockwishlist/views/templates/front/managewishlist.tpl');
            } elseif (Tools::file_exists_cache(dirname(__FILE__).'/views/templates/front/managewishlist.tpl')) {
                $context->smarty->display(dirname(__FILE__).'/views/templates/front/managewishlist.tpl');
            } elseif (Tools::file_exists_cache(dirname(__FILE__).'/managewishlist.tpl')) {
                $context->smarty->display(dirname(__FILE__).'/managewishlist.tpl');
            } else {
                echo $module->l('No template found', 'managewishlist');
            }
        }
    }
}
