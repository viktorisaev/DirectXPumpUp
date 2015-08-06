
struct VS_INPUT
{
	float3 Pos : POSITION;
	float2 Tex : TEXCOORD0;
};

struct VS_TO_PS
{
	float4 Pos : SV_POSITION;
	float2 Tex : TEXCOORD0;
};


Texture2D txDiffuse : register(t0);
SamplerState samLinear : register(s0);



//--------------------------------------------------------------------------------------
// Vertex Shader
//--------------------------------------------------------------------------------------
VS_TO_PS VS(VS_INPUT input)
{
	VS_TO_PS output;
	output.Pos = float4(input.Pos.xyz, 1.0f);
	output.Tex = input.Tex;
	return output;
}


//--------------------------------------------------------------------------------------
// Pixel Shader
//--------------------------------------------------------------------------------------
float4 PS(VS_TO_PS input) : SV_Target
{
	float4 tex = txDiffuse.Sample(samLinear, input.Tex);
//	float4 tex = float4(1.0f, 1.0f, 0.0f, 1.0f);
	return tex;
}