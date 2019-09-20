Shader "SmokePan WIP"
{
	Properties
	{
		_Tex1("Tex1", 2D) = "white" {}
		_ColorTex1("Color Tex1", Color) = (1,1,1,0)
		_TilingTex1("Tiling Tex1", Vector) = (1,1,0,0)
		_PanSpeedTex1("Pan Speed Tex1", Float) = 1
		_OpacityTex1("Opacity Tex1", Float) = 1
		[HDR]_EmissiveColorTex1("EmissiveColor Tex1", Color) = (1,1,1,0)
		_EmissiveStrengthTex1("EmissiveStrength Tex1", Float) = 1
		_Tex2("Tex2", 2D) = "white" {}
		_ColorTex2("Color Tex2", Color) = (1,1,1,0)
		_TilingTex2("Tiling Tex2", Vector) = (1,1,0,0)
		_PanSpeedTex2("Pan Speed Tex2", Float) = 1
		_OpacityTex2("Opacity Tex2", Float) = 1
		[HDR]_EmissiveColorTex2("EmissiveColor Tex2", Color) = (1,1,1,0)
		_EmissiveStrengthTex2("EmissiveStrength Tex2", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 4.6
		#pragma multi_compile_instancing
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Tex2;
		uniform sampler2D _Tex1;

		UNITY_INSTANCING_BUFFER_START(SmokePan)
			UNITY_DEFINE_INSTANCED_PROP(float4, _ColorTex2)
#define _ColorTex2_arr SmokePan
			UNITY_DEFINE_INSTANCED_PROP(float4, _ColorTex1)
#define _ColorTex1_arr SmokePan
			UNITY_DEFINE_INSTANCED_PROP(float4, _EmissiveColorTex1)
#define _EmissiveColorTex1_arr SmokePan
			UNITY_DEFINE_INSTANCED_PROP(float4, _EmissiveColorTex2)
#define _EmissiveColorTex2_arr SmokePan
			UNITY_DEFINE_INSTANCED_PROP(float2, _TilingTex2)
#define _TilingTex2_arr SmokePan
			UNITY_DEFINE_INSTANCED_PROP(float2, _TilingTex1)
#define _TilingTex1_arr SmokePan
			UNITY_DEFINE_INSTANCED_PROP(float, _PanSpeedTex2)
#define _PanSpeedTex2_arr SmokePan
			UNITY_DEFINE_INSTANCED_PROP(float, _OpacityTex2)
#define _OpacityTex2_arr SmokePan
			UNITY_DEFINE_INSTANCED_PROP(float, _PanSpeedTex1)
#define _PanSpeedTex1_arr SmokePan
			UNITY_DEFINE_INSTANCED_PROP(float, _OpacityTex1)
#define _OpacityTex1_arr SmokePan
			UNITY_DEFINE_INSTANCED_PROP(float, _EmissiveStrengthTex1)
#define _EmissiveStrengthTex1_arr SmokePan
			UNITY_DEFINE_INSTANCED_PROP(float, _EmissiveStrengthTex2)
#define _EmissiveStrengthTex2_arr SmokePan
		UNITY_INSTANCING_BUFFER_END(SmokePan)

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 _ColorTex2_Instance = UNITY_ACCESS_INSTANCED_PROP(_ColorTex2_arr, _ColorTex2);
			float2 _TilingTex2_Instance = UNITY_ACCESS_INSTANCED_PROP(_TilingTex2_arr, _TilingTex2);
			float _PanSpeedTex2_Instance = UNITY_ACCESS_INSTANCED_PROP(_PanSpeedTex2_arr, _PanSpeedTex2);
			float4 appendResult22 = (float4(( _PanSpeedTex2_Instance * _Time.y ) , 0.0 , 0.0 , 0.0));
			float2 uv_TexCoord24 = i.uv_texcoord * _TilingTex2_Instance + appendResult22.xy;
			float4 tex2DNode25 = tex2D( _Tex2, uv_TexCoord24 );
			float _OpacityTex2_Instance = UNITY_ACCESS_INSTANCED_PROP(_OpacityTex2_arr, _OpacityTex2);
			float temp_output_34_0 = ( tex2DNode25.a * _OpacityTex2_Instance );
			float4 _ColorTex1_Instance = UNITY_ACCESS_INSTANCED_PROP(_ColorTex1_arr, _ColorTex1);
			float2 _TilingTex1_Instance = UNITY_ACCESS_INSTANCED_PROP(_TilingTex1_arr, _TilingTex1);
			float _PanSpeedTex1_Instance = UNITY_ACCESS_INSTANCED_PROP(_PanSpeedTex1_arr, _PanSpeedTex1);
			float4 appendResult12 = (float4(( _PanSpeedTex1_Instance * _Time.y ) , 0.0 , 0.0 , 0.0));
			float2 uv_TexCoord6 = i.uv_texcoord * _TilingTex1_Instance + appendResult12.xy;
			float4 tex2DNode1 = tex2D( _Tex1, uv_TexCoord6 );
			float _OpacityTex1_Instance = UNITY_ACCESS_INSTANCED_PROP(_OpacityTex1_arr, _OpacityTex1);
			float temp_output_36_0 = ( tex2DNode1.a * _OpacityTex1_Instance );
			float _EmissiveStrengthTex1_Instance = UNITY_ACCESS_INSTANCED_PROP(_EmissiveStrengthTex1_arr, _EmissiveStrengthTex1);
			float4 _EmissiveColorTex1_Instance = UNITY_ACCESS_INSTANCED_PROP(_EmissiveColorTex1_arr, _EmissiveColorTex1);
			float _EmissiveStrengthTex2_Instance = UNITY_ACCESS_INSTANCED_PROP(_EmissiveStrengthTex2_arr, _EmissiveStrengthTex2);
			float4 _EmissiveColorTex2_Instance = UNITY_ACCESS_INSTANCED_PROP(_EmissiveColorTex2_arr, _EmissiveColorTex2);
			o.Emission = ( ( ( ( _ColorTex2_Instance * step( 1E-09 , tex2DNode25.a ) ) * tex2DNode25 * temp_output_34_0 ) + ( ( _ColorTex1_Instance * step( 1E-09 , tex2DNode1.a ) ) * tex2DNode1 * temp_output_36_0 ) ) + ( ( ( tex2DNode1 * ( temp_output_36_0 * ( _EmissiveStrengthTex1_Instance * _EmissiveColorTex1_Instance ) ) ) * _EmissiveColorTex1_Instance.a ) + ( ( tex2DNode25 * ( temp_output_34_0 * ( _EmissiveStrengthTex2_Instance * _EmissiveColorTex2_Instance ) ) ) * _EmissiveColorTex2_Instance.a ) ) ).rgb;
			float temp_output_28_0 = ( temp_output_34_0 + temp_output_36_0 );
			o.Alpha = temp_output_28_0;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Unlit alpha:fade keepalpha fullforwardshadows noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.6
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				SurfaceOutput o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutput, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
}