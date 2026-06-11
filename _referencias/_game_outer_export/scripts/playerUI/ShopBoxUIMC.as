package playerUI
{
   import adobe.utils.*;
   import flash.accessibility.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.sampler.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2263")]
   public dynamic class ShopBoxUIMC extends MovieClip
   {
      
      public var txtDeyPay:TextField;
      
      public var cmdResult:MainButton;
      
      public var moneyPoint:MovieClip;
      
      public var cmdPrvPage:MainButton;
      
      public var goodsContent:MovieClip;
      
      public var titleBox:MovieClip;
      
      public var bgBox:MovieClip;
      
      public var txtPay:TextField;
      
      public var tableBox:MovieClip;
      
      public var cmdClose:SimpleButton;
      
      public var txtPage:TextField;
      
      public var txtPayDatePrompt:TextField;
      
      public var txtDeyMainTitle:TextField;
      
      public var cmdNextPage:MainButton;
      
      public var coinPoint:MovieClip;
      
      public function ShopBoxUIMC()
      {
         super();
         obf_d_I_2791();
         obf_t_A_4469();
         obf_i_h_1688();
      }
      
      internal function obf_t_A_4469() : *
      {
         try
         {
            cmdNextPage["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdNextPage.emphasized = false;
         cmdNextPage.enabled = true;
         cmdNextPage.label = "obf____4854";
         cmdNextPage.labelPlacement = "right";
         cmdNextPage.selected = false;
         cmdNextPage.toggle = false;
         cmdNextPage.visible = true;
         try
         {
            cmdNextPage["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_d_I_2791() : *
      {
         try
         {
            cmdResult["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdResult.emphasized = false;
         cmdResult.enabled = true;
         cmdResult.label = "obf___4893";
         cmdResult.labelPlacement = "right";
         cmdResult.selected = false;
         cmdResult.toggle = false;
         cmdResult.visible = true;
         try
         {
            cmdResult["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_i_h_1688() : *
      {
         try
         {
            cmdPrvPage["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdPrvPage.emphasized = false;
         cmdPrvPage.enabled = true;
         cmdPrvPage.label = "obf____4858";
         cmdPrvPage.labelPlacement = "right";
         cmdPrvPage.selected = false;
         cmdPrvPage.toggle = false;
         cmdPrvPage.visible = true;
         try
         {
            cmdPrvPage["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

