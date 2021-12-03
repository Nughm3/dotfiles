defmodule KV.BucketTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, bucket} = KV.Bucket.start_link([])
    %{bucket: bucket}
  end

  test "stores values by key" do
    {:ok, bucket} = KV.Bucket.start_link([])
    assert KV.Bucket.get(bucket, "milk") == nil

    KV.Bucket.put(bucket, "milk", 3)
    assert KV.Bucket.get(bucket, "milk") == 3
  end

  test "deletes correctly" do
    {:ok, bucket} = KV.Bucket.start_link([])
    KV.Bucket.put(bucket, "milk", 5)
    popped = KV.Bucket.delete(bucket, "milk")
    assert popped == 5
    assert KV.Bucket.get(bucket, "milk") == nil
  end
end
