
Shader "Custom/FurnaceRed"
{
    Properties
    {
        _BaseColor("Base Red Color", Color) = (0.8, 0.1, 0.0, 1)
        _GlowColor("Glow Color", Color) = (1.0, 0.5, 0.0, 1)
        _GlowIntensity("Glow Intensity", Float) = 3.0
        _PulseSpeed("Pulse Speed", Float) = 1.5
    }

    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"="Transparent" }
        LOD 200
        Blend SrcAlpha One
        ZWrite Off

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            float4 _BaseColor;
            float4 _GlowColor;
            float _GlowIntensity;
            float _PulseSpeed;

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
                float pulse = sin(_Time.y * _PulseSpeed) * 0.5 + 0.5;
                float glow = pulse * _GlowIntensity;
                float3 color = _BaseColor.rgb + _GlowColor.rgb * glow;
                return float4(color, saturate(glow));
            }
            ENDCG
        }
    }
}
