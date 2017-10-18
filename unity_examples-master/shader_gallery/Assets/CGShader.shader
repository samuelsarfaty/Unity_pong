Shader "Custom/CGShader"
{
	Properties
	{
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader
	{
		Tags {"Queue" = "Transparent" }
		LOD 100
    Blend SrcAlpha OneMinusSrcAlpha

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
				float3 normal : NORMAL;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
				float3 normal : NORMAL;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
      float4 _Color;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
        o.normal = UnityObjectToWorldNormal(v.normal);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
        float uvx = i.uv.x + _Time;
        float size = ( _SinTime.w + 1) * 0.1;
        float2 diff = float2(frac(uvx*16) - 0.5, frac(i.uv.y*8) - 0.5);
        float alpha = dot(diff, diff) < size ? 1 : 0;
        float diffuseFactor = dot(_WorldSpaceLightPos0, i.normal);
        return fixed4(diffuseFactor, diffuseFactor, diffuseFactor, alpha) * _Color;
			}
			ENDCG
		}
	}
}
