﻿Shader "Unlit/Tutorial2"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _SecondaryTex ("Texture blend", 2D) = "white" {}
        _Color ("Color Tint", Color) = (1,1,1,1)
        _Range ("image blend", Range(0,1)) = 0
    }
    SubShader
    {
        Tags {"Queue"="Transparent" "RenderType"="Transparent" }
        LOD 100
        Cull Off
        Pass
        {

            // Blend One One
            Blend SrcAlpha OneMinusSrcAlpha
            ZWrite Off

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            // #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                // UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            sampler2D _SecondaryTex;
            float4 _Color;
            float4 _MainTex_ST;
            Float _Range;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                // UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // i.uv is position, so text2D fetch color from position;

                // Image disolve into another with range
                // return tex2D(_MainTex, i.uv) * _Range + tex2D(_SecondaryTex, i.uv) * (1 - _Range);

                // Image is tiled once, and colored based on vertex red and green component
                // float4 color = tex2D(_MainTex, i.uv * 2);
                // color.x *= i.uv.r;
                // color.y *= i.uv.g;
                // color.z *= 1;
                // return color;
                float2 displace = tex2D(_SecondaryTex, i.uv + _Time.x).xy;
                displace = ((displace * 2) - 1) * _Range;
                // float4 color = tex2D(_MainTex, i.uv + displace) 
                return tex2D(_MainTex, i.uv + displace) * _Color;

            }
            ENDCG
        }
    }
}
