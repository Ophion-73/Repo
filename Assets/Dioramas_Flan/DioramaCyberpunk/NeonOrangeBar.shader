
Shader "Custom/NeonOrangeBar"
{
    Properties
    {
        _NeonColor("Neon Color", Color) = (1.0, 0.5, 0.0, 1) // Naranja brillante
        _GlowIntensity("Glow Intensity", Float) = 2.5
        _PulseSpeed("Pulse Speed", Float) = 3.0
        _BarSharpness("Bar Sharpness", Float) = 25.0
    }

    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"="Transparent" }
        Blend SrcAlpha One
        ZWrite Off
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            float4 _NeonColor;
            float _GlowIntensity;
            float _PulseSpeed;
            float _BarSharpness;

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

            v2f vert(appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                float y = i.uv.y - 0.5;
                float glow = exp(-abs(y) * _BarSharpness) * (sin(_Time.y * _PulseSpeed) * 0.5 + 0.5);
                float intensity = glow * _GlowIntensity;

                float3 color = _NeonColor.rgb * intensity;
                return float4(color, intensity);
            }
            ENDCG
        }
    }
}
