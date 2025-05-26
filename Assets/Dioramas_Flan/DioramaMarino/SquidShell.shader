
Shader "Custom/SquidShell"
{
    Properties
    {
        _ShellColor("Shell Color", Color) = (0.2, 0.2, 0.25, 1)
        _SpecularColor("Specular Color", Color) = (1, 1, 1, 1)
        _Shininess("Shininess", Float) = 32.0
        _SpecularStrength("Specular Strength", Float) = 1.0
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

            float4 _ShellColor;
            float4 _SpecularColor;
            float _Shininess;
            float _SpecularStrength;

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float3 worldPos : TEXCOORD0;
                float3 worldNormal : TEXCOORD1;
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
                float3 normal = normalize(i.worldNormal);
                float3 reflectDir = reflect(-viewDir, normal);
                float spec = pow(saturate(dot(reflectDir, normal)), _Shininess);
                float3 specular = _SpecularColor.rgb * spec * _SpecularStrength;

                float3 color = _ShellColor.rgb + specular;
                return float4(color, 1.0);
            }
            ENDCG
        }
    }
}
