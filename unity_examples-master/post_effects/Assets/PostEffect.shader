Shader "Hidden/PostEffect" {
  // see http://www.alanzucconi.com/2015/07/08/screen-shaders-and-postprocessing-effects-in-unity3d/
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_BlendAmount ("Black & White blend", Range (0, 1)) = 0
	}
	SubShader {
		Pass {
			CGPROGRAM
      // use the predefined vertex shader vert_img
			#pragma vertex vert_img

      // use our fragment shader
			#pragma fragment frag

			#include "UnityCG.cginc"

			uniform sampler2D _MainTex;
			uniform float _BlendAmount;

      // return a modified version of _MainTex
			float4 frag(v2f_img i) : COLOR {
        // fetch the original pixel from the render
				float4 colour = tex2D(_MainTex, float2(i.uv.x, i.uv.y));
				float4 colour2 = tex2D(_MainTex, float2(1-i.uv.x, i.uv.y));
				
        // calculate the grey scale
				float3 modified = float3(1 - colour2.r, 1 - colour2.g, 1 - colour2.b);
				
        // calculate the grey scale
        float3 blended_colour = lerp(colour.rgb, modified, _BlendAmount);
				return float4(blended_colour, colour.w);
			}
			ENDCG
		}
	}
}
