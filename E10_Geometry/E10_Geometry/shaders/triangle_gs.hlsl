// triangle_gs.hlsl
// Geometry shader example: receives a single point, outputs a triangle around it.

cbuffer MatrixBuffer : register(b0)
{
	matrix worldMatrix;
	matrix viewMatrix;
	matrix projectionMatrix;
};

struct InputType
{
	float4 position : POSITION;
	float2 tex : TEXCOORD0;
	float3 normal : NORMAL;
};

struct OutputType
{
	float4 position : SV_POSITION;
	float2 tex : TEXCOORD0;
	float3 normal : NORMAL;
};

// Receive one point, generate 3 vertices in a triangle stream per point
[maxvertexcount(4)]
void main(point InputType input[1], inout TriangleStream<OutputType> triStream)
{
	OutputType output;

	// Move the first vertex away from the point position
	output.position = input[0].position + float4(0.0, 1.0, 0.0, 0.0);
	output.position = mul(output.position, worldMatrix);
	output.position = mul(output.position, viewMatrix);
	output.position = mul(output.position, projectionMatrix);
    output.tex = float2(0.0, 0.5);
	output.normal = mul(input[0].normal, (float3x3) worldMatrix);
	output.normal = normalize(output.normal);
	triStream.Append(output); // append first vertex to stream

	// Move the second vertex away from the point position
	output.position = input[0].position + float4(-1.0, 0.0, 0.0, 0.0);
	output.position = mul(output.position, worldMatrix);
	output.position = mul(output.position, viewMatrix);
	output.position = mul(output.position, projectionMatrix);
    output.tex = float2(0.5, 0.0);
	output.normal = mul(input[0].normal, (float3x3) worldMatrix);
	output.normal = normalize(output.normal);
	triStream.Append(output); // append second vertex to stream

	// Move the third vertex away from the point position
	output.position = input[0].position + float4(1.0, 0.0, 0.0, 0.0);
	output.position = mul(output.position, worldMatrix);
	output.position = mul(output.position, viewMatrix);
	output.position = mul(output.position, projectionMatrix);
    output.tex = float2(0.5, 1.0);
	output.normal = mul(input[0].normal, (float3x3) worldMatrix);
	output.normal = normalize(output.normal);
	triStream.Append(output); // append third vertex to stream
	
	// Move the fourth vertex away from the point position
    output.position = input[0].position + float4(0.0, -1.0, 0.0, 0.0);
    output.position = mul(output.position, worldMatrix);
    output.position = mul(output.position, viewMatrix);
    output.position = mul(output.position, projectionMatrix);
    output.tex = float2(1.0, 0.5);
    output.normal = mul(input[0].normal, (float3x3) worldMatrix);
    output.normal = normalize(output.normal);
    triStream.Append(output); // append fourth vertex to stream

	// next strip
	triStream.RestartStrip();
}
