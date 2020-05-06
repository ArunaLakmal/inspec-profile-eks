describe aws_s3_bucket('mkit-test') do
  it { should exist }
end

describe aws_s3_bucket('mkit-test') do
  it { should_not be_public }
end

describe aws_eks_cluster('BitesizeEKStest') do
  it { should exist }
end

describe aws_eks_cluster('BitesizeEKStest') do
  its('subnets_count') { should be > 1 }
end

control 'eks-1' do
  impact 0.1
  title 'Subnet Count should be greater than 1'

  desc "Check the Subnet Count"
  desc "remediation", "Subnet count should be greater than 2"
  desc "validation", "verify the cluster VPC subnet again!"

  tag platform: "AWS"
  tag category: "Management and Governance"
  tag resource: "EKS"
  tag effort: 0.5

  ref "EKS Upgrades", url: "#"
  ref "EKS Versions", url: "#"

  describe aws_eks_cluster('BitesizeEKStest') do
    its('subnets_count') { should be > 1 }
  end
end

control 'eks-2' do
  impact 0.1
  title 'Tag compatibility'

  desc "Check the required tags are in place"
  desc "remediation", "Add correct and required tags"
  desc "validation", "verify the cluster tags again!"

  tag platform: "AWS"
  tag category: "Management and Governance"
  tag resource: "EKS"
  tag effort: 0.5

  ref "EKS Upgrades", url: "#"
  ref "EKS Versions", url: "#"

  describe aws_eks_cluster('BitesizeEKStest') do
    its(:tags) { should include( "Environment" => "test", "Inspec" => "mkit", "Name" => "BitesizeEKStest" ) }
  end
end

control 'eks-3' do
  impact 0.4
  title 'Check a bucket existance'

  desc "Custom rule to test non EKS objects, checking a S3 bucket existance"
  desc "remediation", "Check the bucket status, if not create a bucket"
  desc "validation", "verify the bucket again!"

  tag platform: "AWS"
  tag category: "Management and Governance"
  tag resource: "S3"
  tag effort: 0.5

  ref "EKS Upgrades", url: "https://docs.aws.amazon.com/eks/latest/userguide/update-cluster.html"
  ref "EKS Versions", url: "https://docs.aws.amazon.com/eks/latest/userguide/kubernetes-versions.html"

  describe aws_s3_bucket('mkit-test') do
    it { should exist }
  end
end