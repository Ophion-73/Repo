
Shader "Custom/SquidInkShader"
{
    Properties
    {
        _InkColor("Ink Color", Color) = (0.0, 0.0, 0.0, 0.8)
        _PulseSpeed("Pulse Speed", Float) = 1.0
        _DistortStrength("Distortion Strength", Float) = 0.02
        _Expansion("Expansion Amount", Float) = 1.0
    }

    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"="Transparent" }
        Blend SrcAlpha OneMinusSrcAlpha
        ZWrite Off
        LOD 150

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            float4 _InkColor;
            float _PulseSpeed;
            float _DistortStrength;
            float _Expansion;

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

            float noise(float2 p)
            {
                return frac(sin(dot(p, float2(12.9898, 78.233))) * 43758.5453);
            }

            v2f vert(appdata v)
            {
                float time = _Time.y * _PulseSpeed;
                float distortion = sin((v.uv.x + v.uv.y + time) * 10.0) * _DistortStrength;
                v.vertex.xy += distortion;
                v.vertex.xy *= _Expansion;

                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                float alpha = _InkColor.a * (0.8 + 0.2 * sin(_Time.y * _PulseSpeed + i.uv.x * 5.0));
                return float4(_InkColor.rgb, alpha);
            }
            ENDCG
        }
    }
}
