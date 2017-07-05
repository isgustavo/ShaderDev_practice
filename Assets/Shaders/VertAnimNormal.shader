// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/VertAnimNormal" {
	Properties {
		_Color ("Main Color", Color) = (1, 1, 1, 1)
		_MainTex ("Main Texture", 2D) = "white" {}
		_Frequency ("Frequency", Float) = 1
		_Amplitude ("Amplitude", Float) = 1
		_Speed ("Speed", Float) = 1
	}
	SubShader {
		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
		Pass {

			Blend SrcAlpha OneMinusSrcAlpha
			Zwrite Off

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			uniform half4 _Color;
			uniform sampler2D _MainTex;
			uniform float4 _MainTex_ST;
			uniform float _Frequency;
			uniform float _Amplitude;
			uniform float _Speed;

			struct vertexInput {

				float4 vertex: POSITION;
				float4 normal: NORMAL;
				float4 texcoord: TEXCOORD0;

			};

			struct vertexOutput {

				float4 pos: SV_POSITION;
				float4 texcoord: TEXCOORD0;
			};

			float4 vertexAnimNormal (float4 vertPos, float4 vertNormal, float2 uv) {

				vertPos += sin((vertNormal - (_Time.y * _Speed)) * _Frequency) * (vertNormal * _Amplitude);
				return vertPos;
			}

			vertexOutput vert (vertexInput v) {

				vertexOutput o;
				UNITY_INITIALIZE_OUTPUT(vertexOutput, o);
				v.vertex = vertexAnimNormal (v.vertex, v.normal, v.texcoord);
				o.pos = UnityObjectToClipPos(v.vertex);
				o.texcoord.xy = (v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw);
				return o;

			}

			half4 frag (vertexOutput i) : Color {
				
				float4 col = tex2D(_MainTex, i.texcoord) * _Color;
				return col;
			}

			ENDCG
		}
	}
}
