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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol475")]
   public dynamic class FeedGodUIMC extends MovieClip
   {
      
      public var bgBox:MovieClip;
      
      public var cmdRefine:MainButton;
      
      public var txtHeHunBtn:MainButton;
      
      public var txtShowAttrName:TextField;
      
      public var txtYangHunBtn:MainButton;
      
      public var cmdActivate:MainButton;
      
      public var titleBox:MovieClip;
      
      public var txtShowAttrs:TextField;
      
      public var pointHeHun:MovieClip;
      
      public var cmdClose:SimpleButton;
      
      public var txtEquip:TextField;
      
      public var txtExplain:TextField;
      
      public var cmdHeHun:MainButton;
      
      public var bgBox1:MovieClip;
      
      public var bgBox2:MovieClip;
      
      public var txtDeyTitle:TextField;
      
      public var txtConform:TextField;
      
      public var iconEquip:IconBarMC;
      
      public var pointMCYangHun:MovieClip;
      
      public function FeedGodUIMC()
      {
         super();
         obf_F_b_4312();
         obf_a_p_2057();
         obf_E_4657();
         obf_w_R_2169();
         obf_2_k_2891();
      }
      
      internal function obf_E_4657() : *
      {
         try
         {
            txtHeHunBtn["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         txtHeHunBtn.emphasized = false;
         txtHeHunBtn.enabled = true;
         txtHeHunBtn.label = "obf___4927";
         txtHeHunBtn.labelPlacement = "right";
         txtHeHunBtn.selected = false;
         txtHeHunBtn.toggle = false;
         txtHeHunBtn.visible = true;
         try
         {
            txtHeHunBtn["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_a_p_2057() : *
      {
         try
         {
            cmdRefine["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdRefine.emphasized = false;
         cmdRefine.enabled = true;
         cmdRefine.label = "obf___4872";
         cmdRefine.labelPlacement = "right";
         cmdRefine.selected = false;
         cmdRefine.toggle = false;
         cmdRefine.visible = true;
         try
         {
            cmdRefine["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_F_b_4312() : *
      {
         try
         {
            cmdHeHun["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdHeHun.emphasized = false;
         cmdHeHun.enabled = true;
         cmdHeHun.label = "obf___4927";
         cmdHeHun.labelPlacement = "right";
         cmdHeHun.selected = false;
         cmdHeHun.toggle = false;
         cmdHeHun.visible = true;
         try
         {
            cmdHeHun["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_2_k_2891() : *
      {
         try
         {
            txtYangHunBtn["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         txtYangHunBtn.emphasized = false;
         txtYangHunBtn.enabled = true;
         txtYangHunBtn.label = "obf___4885";
         txtYangHunBtn.labelPlacement = "right";
         txtYangHunBtn.selected = false;
         txtYangHunBtn.toggle = false;
         txtYangHunBtn.visible = true;
         try
         {
            txtYangHunBtn["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_w_R_2169() : *
      {
         try
         {
            cmdActivate["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdActivate.emphasized = false;
         cmdActivate.enabled = true;
         cmdActivate.label = "obf___4875";
         cmdActivate.labelPlacement = "right";
         cmdActivate.selected = false;
         cmdActivate.toggle = false;
         cmdActivate.visible = true;
         try
         {
            cmdActivate["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

