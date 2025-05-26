
Shader "Custom/MetalShader"
{
    Properties
    {
        _MetalColor("Metal Color", Color) = (0.7, 0.7, 0.75, 1)
        _HighlightColor("Highlight Color", Color) = (1, 1, 1, 1)
        _Shininess("Shininess", Float) = 64.0
        _ReflectionStrength("Reflection Strength", Float) = 0.8
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

            float4 _MetalColor;
            float4 _HighlightColor;
            float _Shininess;
            float _ReflectionStrength;

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float3 worldNormal : TEXCOORD0;
                float3 worldPos : TEXCOORD1;
            };

            v2f vert(appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                o.worldNormal = UnityObjectToWorldNormal(v.normal);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                float3 viewDir = normalize(_WorldSpaceCameraPos - i.worldPos);
                float3 reflectDir = reflect(-viewDir, normalize(i.worldNormal));
                float spec = pow(saturate(dot(reflectDir, normalize(i.worldNormal))), _Shininess);
                float3 color = _MetalColor.rgb + _HighlightColor.rgb * spec * _ReflectionStrength;
                return float4(color, 1.0);
            }
            ENDCG
        }
    }
}
