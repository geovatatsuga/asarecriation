package playerUI
{
   import adobe.utils.*;
   import fl.controls.UIScrollBar;
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1262")]
   public dynamic class NewShopBoxMC extends MovieClip
   {
      
      public var txtDeyPay:TextField;
      
      public var cmdNextPage:SimpleButton;
      
      public var bg:MovieClip;
      
      public var obf_H_w_3575:UIScrollBar;
      
      public var moneyPoint:MovieClip;
      
      public var cmdPrvPage:SimpleButton;
      
      public var txtPay:TextField;
      
      public var txtUpPage:TextField;
      
      public var goodsContent:MovieClip;
      
      public var tableBox:MovieClip;
      
      public var cmdClose:SimpleButton;
      
      public var txtPage:TextField;
      
      public var txtDownPage:TextField;
      
      public var txtPayDatePrompt:TextField;
      
      public var leavingsTime:TextField;
      
      public var txtConfiscate:TextField;
      
      public var cmdResult:SimpleButton;
      
      public var itemPoint:MovieClip;
      
      public var coinPoint:MovieClip;
      
      public function NewShopBoxMC()
      {
         super();
         obf_h_c_1399();
      }
      
      internal function obf_h_c_1399() : *
      {
         try
         {
            obf_H_w_3575["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         obf_H_w_3575.direction = "vertical";
         obf_H_w_3575.scrollTargetName = "Leadbg";
         obf_H_w_3575.visible = true;
         try
         {
            obf_H_w_3575["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

