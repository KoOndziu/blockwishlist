{*
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
*}

<a 
  class="lnk_wishlist col-lg-4 col-md-6 col-sm-6 col-xs-12" 
  id="emailsalerts" 
  href="{$link->getModuleLink('blockwishlist', 'mywishlist', array(), true)|escape:'html':'UTF-8'}" 
  title="{l s='My wishlists' mod='blockwishlist'}"
  >
  <span class="link-item">
    <i class="material-icons">favorite</i>
    {l s='My wishlists' mod='blockwishlist'}
  </span>
</a>