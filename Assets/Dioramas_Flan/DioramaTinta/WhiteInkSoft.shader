
Shader "Custom/WhiteInkSoft"
{
    Properties
    {
        _InkColor("Ink Color", Color) = (1.0, 1.0, 1.0, 0.5)
        _FlowSpeed("Flow Speed", Float) = 1.0
        _FlowStrength("Flow Strength", Float) = 0.01
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
            float _FlowSpeed;
            float _FlowStrength;

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
                float t = _Time.y * _FlowSpeed;
                v.vertex.x += sin(v.uv.y * 10.0 + t) * _FlowStrength;
                v.vertex.y += cos(v.uv.x * 10.0 + t) * _FlowStrength;
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                return float4(_InkColor.rgb, _InkColor.a);
            }
            ENDCG
        }
    }
}
