
Shader "Custom/CartoonBlackEyes"
{
    Properties
    {
        _EyeColor("Eye Color", Color) = (0.02, 0.02, 0.02, 1) // Negro profundo
        _HighlightColor("Highlight Color", Color) = (1, 1, 1, 1)
        _HighlightSize("Highlight Size", Float) = 0.1
        _HighlightPosition("Highlight Position", Vector) = (0.2, 0.2, 0, 0)
    }

    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            float4 _EyeColor;
            float4 _HighlightColor;
            float _HighlightSize;
            float4 _HighlightPosition;

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

            float circle(float2 uv, float2 center, float radius)
            {
                return smoothstep(radius, radius - 0.01, distance(uv, center));
            }

            fixed4 frag(v2f i) : SV_Target
            {
                float highlight = 1.0 - circle(i.uv, _HighlightPosition.xy, _HighlightSize);
                float3 color = _EyeColor.rgb + _HighlightColor.rgb * highlight;
                return float4(color, 1.0);
            }
            ENDCG
        }
    }
}
