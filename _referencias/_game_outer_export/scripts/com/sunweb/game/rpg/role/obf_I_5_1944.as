package com.sunweb.game.rpg.role
{
   import com.sunweb.game.res.ResourceBag;
   import com.sunweb.game.res.ResourceManager;
   import com.sunweb.game.res.obf_J_Y_3494;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import jobIcon.Animal_Big;
   import jobIcon.Druid_Big;
   import jobIcon.Elf_Big;
   import jobIcon.Fairy_Big;
   import jobIcon.Killer_Big;
   import jobIcon.Paladin_Big;
   import jobIcon.Priest_Big;
   
   public class obf_I_5_1944
   {
      
      private static var obf_y_s_3221:Object;
      
      private static var obf_U_3_1522:Object;
      
      public static const obf_y_D_2468:int = 0;
      
      public static const obf_e_w_3507:int = 1;
      
      public static const obf_A_t_4218:int = 2;
      
      public static const obf_k_L_3388:int = 3;
      
      public static const obf_b_Q_2292:int = 4;
      
      public static const obf_0_1_133:int = 5;
      
      public static const obf_U_K_1768:int = 6;
      
      private static const obf_V_y_4555:Array = ["paladin","elf","killer","fairy","priest","trainer","druid"];
      
      private static var obf_f_x_4065:Object = {
         "paladin":"ou0",
         "elf":"ou1",
         "killer":"ou2",
         "fairy":"ou3",
         "priest":"ou4",
         "trainer":"ou5",
         "druid":"ou6"
      };
      
      public function obf_I_5_1944()
      {
         super();
      }
      
      public static function getJobImage(param1:int, param2:int) : DisplayObject
      {
         var _loc6_:ResourceBag = null;
         if(param1 < 0 || param1 >= obf_V_y_4555.length || param2 < 0 || param2 > 1)
         {
            return null;
         }
         initJobImage();
         var _loc3_:Sprite = new Sprite();
         var _loc4_:String = obf_V_y_4555[param1];
         var _loc5_:MovieClip = ResourceManager.instance.getMovieClip("sex" + param2 + "@" + obf_f_x_4065[_loc4_]);
         if(_loc5_)
         {
            _loc3_.addChild(_loc5_);
         }
         else
         {
            _loc3_.name = "sex" + param2 + "@" + obf_f_x_4065[_loc4_];
            obf_y_s_3221[param1 + param2 + "_" + Math.random()] = _loc3_;
            _loc6_ = obf_U_3_1522[_loc4_];
            if(_loc6_)
            {
               _loc6_.load();
            }
         }
         return _loc3_;
      }
      
      private static function initJobImage() : void
      {
         var _loc1_:String = null;
         var _loc2_:ResourceBag = null;
         if(!obf_y_s_3221)
         {
            obf_y_s_3221 = new Object();
         }
         if(!obf_U_3_1522)
         {
            obf_U_3_1522 = new Object();
            for each(_loc1_ in obf_V_y_4555)
            {
               _loc2_ = ResourceManager.instance.getBag("JobImage_" + _loc1_,true);
               _loc2_.obf_z_U_2156(obf_f_x_4065[_loc1_]);
               _loc2_.loader.addEventListener(obf_J_Y_3494.COMPLETE,obf_a_m_2542);
               obf_U_3_1522[_loc1_] = _loc2_;
            }
         }
      }
      
      private static function obf_a_m_2542(param1:obf_J_Y_3494) : void
      {
         var _loc2_:String = null;
         var _loc3_:Sprite = null;
         var _loc4_:MovieClip = null;
         for(_loc2_ in obf_y_s_3221)
         {
            _loc3_ = obf_y_s_3221[_loc2_];
            if(Boolean(_loc3_) && _loc3_.numChildren == 0)
            {
               _loc4_ = ResourceManager.instance.getMovieClip(_loc3_.name);
               if(_loc4_)
               {
                  _loc3_.addChild(_loc4_);
                  delete obf_y_s_3221[_loc2_];
               }
            }
         }
      }
      
      public static function destroyJobImage() : void
      {
      }
      
      public static function getJobName(param1:int, param2:int = -1) : String
      {
         var _loc3_:String = "";
         if(param1 >= 0 && param1 < obf_V_y_4555.length)
         {
            _loc3_ = obf_V_y_4555[param1];
         }
         if(_loc3_ != "" && param2 > -1)
         {
            _loc3_ += param2 + "";
         }
         return _loc3_;
      }
      
      public static function getJobShowName(param1:int) : String
      {
         return DiversityManager.getString("PlayerJob",param1 + "");
      }
      
      public static function getJobIcon32(param1:int) : DisplayObject
      {
         if(param1 == obf_y_D_2468)
         {
            return new Paladin_Big();
         }
         if(param1 == obf_e_w_3507)
         {
            return new Elf_Big();
         }
         if(param1 == obf_A_t_4218)
         {
            return new Killer_Big();
         }
         if(param1 == obf_k_L_3388)
         {
            return new Fairy_Big();
         }
         if(param1 == obf_b_Q_2292)
         {
            return new Priest_Big();
         }
         if(param1 == obf_0_1_133)
         {
            return new Animal_Big();
         }
         if(param1 == obf_U_K_1768)
         {
            return new Druid_Big();
         }
         return null;
      }
   }
}

