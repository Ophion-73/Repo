
Shader "Custom/SolarFlareShader"
{
    Properties
    {
        _CoreColor("Core Color", Color) = (1.0, 0.6, 0.0, 1)
        _FlareColor("Flare Color", Color) = (1.0, 1.0, 0.0, 1)
        _PulseSpeed("Pulse Speed", Float) = 2.0
        _FlareIntensity("Flare Intensity", Float) = 1.5
    }

    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 250

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            float4 _CoreColor;
            float4 _FlareColor;
            float _PulseSpeed;
            float _FlareIntensity;

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

            float flare(float2 uv, float t)
            {
                return sin(uv.x * 20.0 + t) * cos(uv.y * 20.0 + t);
            }

            v2f vert(appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                float t = _Time.y * _PulseSpeed;
                float f = flare(i.uv, t);
                float glow = f * _FlareIntensity;
                float3 color = _CoreColor.rgb + _FlareColor.rgb * glow;
                return float4(color, 1.0);
            }
            ENDCG
        }
    }
}
