
Shader "Custom/LivingBlueBall"
{
    Properties
    {
        _BaseColor("Base Color", Color) = (0.1, 0.3, 1.0, 1) // Azul brillante
        _GlowColor("Glow Color", Color) = (0.5, 0.8, 1.0, 1) // Brillo celeste
        _GlowSpeed("Glow Speed", Float) = 3.0
        _GlowIntensity("Glow Intensity", Float) = 1.5
        _PulseNoiseScale("Pulse Noise Scale", Float) = 6.0
    }

    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            float4 _BaseColor;
            float4 _GlowColor;
            float _GlowSpeed;
            float _GlowIntensity;
            float _PulseNoiseScale;

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float3 worldPos : TEXCOORD0;
                float3 normal : TEXCOORD1;
            };

            // Simple fake noise function using sine waves
            float fakeNoise(float3 pos, float scale, float t)
            {
                return sin(dot(pos * scale, float3(12.9898, 78.233, 37.719)) + t);
            }

            v2f vert(appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                o.normal = UnityObjectToWorldNormal(v.normal);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                float noise = fakeNoise(i.worldPos, _PulseNoiseScale, _Time.y * _GlowSpeed);
                float glow = (noise * 0.5 + 0.5) * _GlowIntensity;

                float3 finalColor = _BaseColor.rgb + glow * _GlowColor.rgb;
                return float4(finalColor, 1.0);
            }
            ENDCG
        }
    }
}
