Shader "Unlit/ShaderWater"
{
    Properties
    {
        _Color ("Water Color", Color) = (0, 0.5, 1, 1)
        _Transparency ("Transparency", Range(0, 1)) = 0.5
        _WaveSpeed ("Wave Speed", Float) = 0.5
        _WaveScale ("Wave Scale", Float) = 0.1
        _Glossiness ("Glossiness", Range(0, 1)) = 0.5
        _MainTex ("Texture", 2D) = "white" {}
    }

    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            Tags { "Queue"="Overlay" }
            Blend SrcAlpha OneMinusSrcAlpha

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            sampler2D _MainTex;
            float4 _Color;
            float _WaveSpeed;
            float _WaveScale;
            float _Glossiness;
            float _Transparency;

            v2f vert(appdata v)
            {
                v2f o;
                float wave = sin(_Time.y * _WaveSpeed + v.vertex.x * _WaveScale);
                v.vertex.y += wave * 0.1;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                float wave = sin(_Time.y * _WaveSpeed + i.uv.x * _WaveScale);
                float4 col = tex2D(_MainTex, i.uv + wave * 0.02);
                col.rgb *= _Color.rgb;
                col.a = _Transparency;
                float spec = pow(max(dot(normalize(float3(0,1,0)), float3(0,0,1)), 0), _Glossiness * 128);
                col.rgb += spec;
                return col;
            }
            ENDCG
        }
    }

    FallBack "Diffuse"
}
